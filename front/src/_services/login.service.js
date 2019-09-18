import axios from 'axios'

export const loginService = {
    loginUser
}

function loginUser(email, password) {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users', {
                user: {
                    email: email,
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