// Node 18+ (fetch natif)
import { readdir, readFile } from "node:fs/promises";
import path from "node:path";

const TRELLO_KEY = process.env.TRELLO_KEY;
const TRELLO_TOKEN = process.env.TRELLO_TOKEN;
const TRELLO_LIST_ID = process.env.TRELLO_LIST_ID;

if (!TRELLO_KEY || !TRELLO_TOKEN || !TRELLO_LIST_ID) {
    console.error("Variables requises: TRELLO_KEY, TRELLO_TOKEN, TRELLO_LIST_ID");
    process.exit(1);
}

const ISSUES_DIR = process.env.ISSUES_DIR || ".github/issue-seed";

function parseMd(md) {
    const lines = md.split(/\r?\n/);
    // Accepte #, ##, ### ...
    const titleLine = lines.find((l) => /^#{1,6}\s+/.test(l.trim()));
    if (!titleLine) {
        throw new Error(
            "Titre introuvable (ligne commençant par #, ##, ###, ...)"
        );
    }

    const title = titleLine.replace(/^#\s+/, "").trim();
    const idx = lines.indexOf(titleLine);
    const desc = lines.slice(idx + 1).join("\n").trim();

    return { title, desc };
}

async function createCard({ name, desc }) {
    const url = new URL("https://api.trello.com/1/cards");
    url.searchParams.set("key", TRELLO_KEY);
    url.searchParams.set("token", TRELLO_TOKEN);

    const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json", Accept: "application/json" },
        body: JSON.stringify({ idList: TRELLO_LIST_ID, name, desc }),
    });

    if (!res.ok) throw new Error(`Erreur Trello ${res.status}: ${await res.text()}`);
    return res.json();
}

async function main() {
    const files = (await readdir(ISSUES_DIR))
        .filter((f) => f.toLowerCase().endsWith(".md"))
        .sort((a, b) => a.localeCompare(b, "fr"));

    for (const file of files) {
        const fullPath = path.join(ISSUES_DIR, file);
        const md = await readFile(fullPath, "utf-8");
        const { title, desc } = parseMd(md);
        console.log(title);

        const card = await createCard({ name: title, desc });
        console.log(`OK: ${file} -> ${card.url}`);
    }
}

main().catch((e) => {
    console.error(e);
    process.exit(1);
});
