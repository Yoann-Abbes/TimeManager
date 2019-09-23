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

function logout() {
    return new Promise((resolve, reject) => {
        const regex = /Bearer /gi
        console.log(axios.defaults.headers.common['Authorization'].replace(regex, ''))
        axios.delete(process.env.VUE_APP_API_URL + '/api/users/sign_out',{
            headers:{
                "x-xsrf-token": axios.defaults.headers.common['Authorization'].replace(regex, '')
            }
        }).then(
            success => {
                delete axios.defaults.headers.common['Authorization']
                localStorage.removeItem('user')
                resolve()
            }
        )
    })
}