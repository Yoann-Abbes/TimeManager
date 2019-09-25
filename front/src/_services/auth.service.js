import axios from 'axios'

export const authService = {
    login,
    logout
}

function login(username, password) {
    return new Promise((resolve, reject) => {
        axios.post(process.env.VUE_APP_API_URL + '/api/users/sign_in', {
            user:{
                username: username,
                password: password
            }
        })
            .then(success => {
                localStorage.setItem('user', JSON.stringify(success.data))
                axios.defaults.headers.common['Authorization'] = 'Bearer '+ success.data.jwt;
                resolve(success)
            })
            .catch(error => {
                reject(error)
            })
    })
}

function logout(token) {
    delete axios.defaults.headers.common['Authorization']
    localStorage.removeItem('user')
    location.reload()
}