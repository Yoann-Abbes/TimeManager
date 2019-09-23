import { authService } from '../../_services/auth.service'
import router from '../../_helpers/router'

export const authModule = {
    namespaced: true,
    state: {
        status: '',
        token: ''
    },
    getters: {
        getStatus: state => state.status
    },
    mutations: {
        loginLoading(state) {
            state.status = 'loading'
        },
        loginError(state) {
            state.status = 'error'
        },
        loginSuccess(state, payload) {
            state.status = 'success'
            state.token = payload.data.jwt
        },
        logout(state) {
            state.status = ''
            state.token = ''
        }
    },
    actions: {
        login({ commit }, { username, password }) {
            commit('loginLoading')
            authService.login(username, password).then(
                success => {
                    commit('loginSuccess', success)
                    router.push('/')
                },
                error => {
                    commit('loginError')
                }
            )
        },
        logout({ commit }) {
            commit('logout')
            authService.logout().then(
                success => {
                    location.reload()
                }
            )
        }
    }
}