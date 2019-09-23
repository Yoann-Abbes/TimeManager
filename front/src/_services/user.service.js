import axios from 'axios'

export const userService = {
    createUser,
    updateUser,
    getUser,
    deleteUser
}

function createUser(username, email, firstname, lastname, password) {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users/sign_up', {
                user: {
                    username: username,
                    email: email,
                    firstname: firstname,
                    lastname: lastname,
                    password: password
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

function updateUser(id, username, email, firstname, lastname, password, roleId) {
    return new Promise((resolve, reject) => {
        axios.put(process.env.VUE_APP_API_URL + '/api/users/' + id, {
                user: {
                    username: username,
                    email: email,
                    firstname: firstname,
                    lastname: lastname,
                    password: password,
                    roleId: roleId
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
                reject(error)
            })
    })
}