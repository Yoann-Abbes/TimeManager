import axios from 'axios'
import Vue from 'vue'

export const userService = {
    createUser,
    updateUser,
    getUser,
    deleteUser,
    getLoggedUser
}

function createUser(username, email, firstname, lastname, password, role) {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users/sign_up', {
                user: {
                    username: username,
                    email: email,
                    firstname: firstname,
                    lastname: lastname,
                    password: password,
                    role_id: role
                }
            })
            .then(success => {
                Vue.toasted.show('Created with success !', { position: 'bottom-right', type: 'success', theme:'outline', icon: 'sentiment_very_satisfied',  duration : 5000})
                resolve(success)
            })
            .catch(error => {
                Vue.toasted.show('An error occured while creating', { position: 'bottom-right', type: 'error', theme:'outline', icon: 'sentiment_dissatisfied',  duration : 5000})
                reject(error)
            })
    })
}

function updateUser(id, username, email, firstname, lastname) {
    return new Promise((resolve, reject) => {
        axios.put(process.env.VUE_APP_API_URL + '/api/users/' + id, {
            user:{
                username: username,
                email: email,
                firstname: firstname,
                lastname: lastname

            }
            })
            .then(success => {
                Vue.toasted.show('Updated with success !', { position: 'bottom-right', type: 'success', theme:'outline', icon: 'sentiment_very_satisfied',  duration : 5000})
                resolve(success)
            })
            .catch(error => {
                Vue.toasted.show('An error occured while updating', { position: 'bottom-right', type: 'error', theme:'outline', icon: 'sentiment_dissatisfied',  duration : 5000})
                reject(error)
            })
    })
}

function getUser(id) {
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

function deleteUser(id) {
    return new Promise((resolve, reject) => {
        axios.delete(process.env.VUE_APP_API_URL + '/api/users/' + id)
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                Vue.toasted.show('An error occured while deleting', { position: 'bottom-right', type: 'error', theme:'outline', icon: 'sentiment_dissatisfied',  duration : 5000})
                reject(error)
            })
    })
}

function getLoggedUser(){
    return new Promise((resolve, reject) => {
        axios.get(process.env.VUE_APP_API_URL + '/api/users/me')
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                reject(error)
            })
    })
}