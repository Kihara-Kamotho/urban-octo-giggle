import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link", "lessons"]

  connect() {
    this.linkTargets.forEach(link => {
      link.addEventListener("mouseover", this.loadLessons)
      link.addEventListener("click", this.loadLessons)
    })
  }

  disconnect() {
    this.linkTargets.forEach(link => {
      link.removeEventListener("mouseover", this.loadLessons)
      link.removeEventListener("click", this.loadLessons)
    })
  }

  loadLessons = (event) => {
    event.preventDefault();
    const sectionId = event.currentTarget.dataset.sectionId
    const url = `/sections/${sectionId}/lessons`

    fetch(url)
      .then(response => response.text())
      .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        this.lessonsTarget.innerHTML = doc.querySelector("#lessons").innerHTML;
      })
  }
}
