class TopClick {
    constructor() {
        const btn = document.getElementById("to-top-button");
        if (btn) {
            btn.addEventListener("click", (e: Event) => this.go());
        }
    }

    private go() {
        window.scroll({
            top: 0,
            behavior: "smooth",
        });
    }
}

export default TopClick;