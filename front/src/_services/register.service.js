import axios from 'axios'

export const registerService = {
    registerUser
}

function registerUser(username, email, firstname, lastname, password, role) {
    console.log("CDSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSsSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users', {
                user: {
                    email: email,
                    password: password,
                    username: username,
                    firstname: firstname,
                    lastname: lastname,
                    role: role
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