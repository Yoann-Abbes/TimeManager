import axios from 'axios'

export const userService = {
    createUser,
    updateUser,
    getUser,
    deleteUser
}

function createUser(username, email){
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users', {
                user: {
                    username: username,
                    email: email
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

function updateUser(id, username, email){
    return new Promise((resolve, reject) => {
        axios.put(process.env.VUE_APP_API_URL + '/api/users/' + id,{
            user:{
                username: username,
                email: email
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

function getUser(id){
    return new Promise((resolve, reject) => {
        axios.get(process.env.VUE_APP_API_URL + '/api/users/' + id)
        .then(success => {
            resolve(success)
        })
        .catch(error => {
            reject(error)
        })
    })
}

function deleteUser(id){
    return new Promise((resolve, reject) => {
        axios.delete(process.env.VUE_APP_API_URL + '/api/users/' + id)
        .then(success => {
            resolve(success)
        })
        .catch(error => {
                reject(error)
        })
    })
}