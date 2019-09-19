import axios from 'axios'

export const authService = {
    login,
    logout
}

function login(email, password) {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users/sign_in', {
                user:{
                    email: email,
                    password: password
                }
            })
            .then(success => {
                localStorage.setItem('user', JSON.stringify(success.data))
                axios.defaults.headers.common['Authorization'] = success.data.jwt;
                resolve(success)
            })
            .catch(error => {
                reject(error)
            })
    })
}

function logout() {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users/sign_out').then(
            success => {
                delete axios.defaults.headers.common['Authorization']
                localStorage.removeItem('user')
                resolve()
            }
        )
    })
}