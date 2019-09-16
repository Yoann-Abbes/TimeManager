import axios from "axios";

export const workingTimesService = {
    getWorkingTimes,
    createWorkingTime,
    updateWorkingTime,
    deleteWorkingTime
}

function getWorkingTimes(userId){
    return new Promise((resolve, reject) => {
        axios.get(process.env.VUE_APP_API_URL + '/api/workingtimes/' + userId)
        .then(success => {
            resolve(success)
        })
        .catch(error => {
            reject(error)
        })
    })
}

function createWorkingTime(userId, start, end){
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/workingtimes/' + userId, {
            working_time:{
                start: start,
                end: end
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

function updateWorkingTime(id, start, end){
    return new Promise((resolve, reject) => {
        axios.put(process.env.VUE_APP_API_URL + '/api/workingtimes/' + id, {
            working_time:{
                start: start,
                end: end
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

function deleteWorkingTime(id){
    return new Promise((resolve, reject) => {
        axios.delete(process.env.VUE_APP_API_URL + '/api/workingtimes/' + id)
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                reject(error)
            })
    })
}