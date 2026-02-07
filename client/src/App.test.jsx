import { render, screen } from "@testing-library/react";
import { describe, it, expect } from "vitest";
import App from "./App.jsx";

describe("App", () => {
    it("affiche un contenu attendu", () => {
        render(<App />);
        // adapte la regex à un texte réellement présent dans ton App
        expect(screen.getByRole("heading", { name: "Vite + React" })).toBeInTheDocument();
    });
});
