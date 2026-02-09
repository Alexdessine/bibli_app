import { useEffect, useState } from "react";

function App() {
    const [status, setStatus] = useState(null);

    useEffect(() => {
        fetch("/api/health")
            .then(res => res.json())
            .then(data => setStatus(data.ok))
            .catch(err => console.error(err));
    }, []);

    useEffect(() => {
        fetch("/api/about")
            .then(res => res.text())
            .then(data => console.log(data))
            .catch(err => console.error(err));
    }, []);

    return (
        <div>
            <h1>API status: {status ? "OK" : "Loading..."}</h1>
        </div>
    );
}

export default App;
