import {Controller} from 'stimulus'

export default class extends Controller {
    close(){
        console.log("click")
        this.element.open = false
    }
}