import {Controller} from 'stimulus'

export default class extends Controller {
    static targets = ["slides", "slide", "previous", "next"]

    // INITIALIZER
    connect() {
        this._currentIndex = 0
        this.totalIndexes = this.slidesCount
    }

    // BEHAVIOR

    prev() {
        if (this.hasStarted()) {
            this.currentIndex = (this.currentIndex - 1)
            this.slidesTarget.scrollLeft -= this.slideTarget.offsetWidth
        }
        this.updateSteppersVisibility()
    }

    next() {
        if (!this.hasEnded()) {
            this.currentIndex = (this.currentIndex + 1)
            this.slidesTarget.scrollLeft += this.slideTarget.offsetWidth
        }
        this.updateSteppersVisibility()
    }

    hasStarted() {
        return this.currentIndex > 0
    }

    hasEnded() {
        return this.currentIndex === this.slidesCount
    }

    updateSteppersVisibility() {
        this.toggle(this.nextTarget, this.hasEnded())
        this.toggle(this.previousTarget, !this.hasStarted())
    }

    toggle(stepper, force) {
        stepper.classList.toggle("hidden", force)
    }

    // GETTERS & SETTERS

    get currentIndex() {
        return this._currentIndex
    }

    get slideIndex() {
        return Number(this.element.dataset.slideIndex)
    }

    get slidesCount() {
        return this.slideTargets.length
    }

    set currentIndex(value) {
        this._currentIndex = value
        this.element.dataset.currentIndex = this._currentIndex
    }

    set totalIndexes(slidesCount) {
        this.element.dataset.totalIndexes = slidesCount
    }
}