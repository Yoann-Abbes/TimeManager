import axios from 'axios'

export const authService = {
    login
}

function login(email, password) {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/login', {
                email: email,
                password: password
            })
            .then(success => {
                resolve(success)
            })
            .catch(error => {
                reject(error)
            })
    })
}

function logout() {
    console.log("LOGOUT");
}