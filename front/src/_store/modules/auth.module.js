import { authService } from '../../_services/auth.service'

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
            state.token = payload.token
        },
        logout(state) {
            state.status = ''
            state.token = ''
        }
    },
    actions: {
        login({ commit }, { email, password }) {
            commit('loginLoading')
            authService.login(email, password).then(
                success => {
                    commit('loginSuccess', success)
                },
                error => {
                    commit('loginError')
                }
            )
        },
        logout({ commit }) {
            commit('logout')
            authService.logout()
        }
    }
}