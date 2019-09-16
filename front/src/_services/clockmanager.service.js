import axios from "axios";

export const clockManagerService = {
    createClock,
    updateClock,
    getClock
}

function createClock(userId){
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/clocks/' + userId)
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                reject(error)
            })
    })
}

function updateClock(userId, status){
    return new Promise((resolve, reject) => {
        axios.put(process.env.VUE_APP_API_URL + '/api/clocks/' + userId, {
            clocks: {
                status: !status
            }
        })
            .then(success => {
                resolve(success)
            })
            .catch(error => {
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
                reject(error)
            })
    })
}