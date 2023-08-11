import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "openIcon", "closeIcon"];

  connect() {
    this.hideContent();
  }

  toggle() {
    if (this.isExpanded()) {
      this.hideContent();
    } else {
      this.showContent();
    }
  }

  isExpanded() {
    return this.data.get("expanded") === "true";
  }

  hideContent() {
    this.contentTarget.style.display = "none";
    this.data.set("expanded", "false");
    this.openIconTarget.style.display = "block";
    this.closeIconTarget.style.display = "none";
  }

  showContent() {
    this.contentTarget.style.display = "block";
    this.data.set("expanded", "true");
    this.openIconTarget.style.display = "none";
    this.closeIconTarget.style.display = "block";
  }
}
