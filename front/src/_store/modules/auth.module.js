import { authService } from '../../_services/auth.service'
import router from '../../_helpers/router'
import store from "../index";

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
        reload(state, token){
            state.status = 'success'
            state.token = token
        }
    },
    actions: {
        login({ commit }, { username, password }) {
            commit('loginLoading')
            authService.login(username, password).then(
                success => {
                    commit('loginSuccess', success)
                    store.dispatch('userModule/getLoggedUser')
                    router.push('/')
                },
                error => {
                    commit('loginError')
                }
            )
        },
        logout() {
            authService.logout()
        },
        reload({commit}) {
            commit('reload', JSON.parse(localStorage.getItem('user')).jwt)
        }
    }
}