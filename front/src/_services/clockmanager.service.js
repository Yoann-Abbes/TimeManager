import axios from "axios";
import Vue from "vue";

export const clockManagerService = {
    createClock,
    getClock
}

function createClock(userId, status){
    let dt = new Date()
    dt.setHours(dt.getHours() + 2)
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/clocks/'+ userId, {
            clocks:{
                time: dt,
                status: !status
            }
        })
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                    Vue.toasted.show('An error occured while created/changed clock', { position: 'bottom-right', type: 'error', theme:'outline', icon: 'sentiment_dissatisfied',  duration : 5000})
                    reject(error)
            })
    })
}

function getClock(userId){
    return new Promise((resolve, reject) => {
        axios.get(process.env.VUE_APP_API_URL + '/api/clocks/' + userId)
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                Vue.toasted.show('Can\'t get current clock', { position: 'bottom-right', type: 'error', theme:'outline', icon: 'sentiment_dissatisfied',  duration : 5000})
                reject(error)
            })
    })
}