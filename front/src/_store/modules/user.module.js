import { userService } from '../../_services/user.service'

export const userModule = {
    namespaced: true,
    state: {
        logged: {
            status: '',
            id: '',
            username: '',
            email: '',
            role: '',
            skill: ''
        },
        create: {
            status: ''
        },
        update: {
            status: ''
        },
        delete: {
            status: ''
        },
        get: {
            status: '',
            id: '',
            username: '',
            email: '',
            role: '',
            skill: ''
        },
        userList: {
            status: '',
            data: []
        }
    },
    getters: {
        getLoggedUser: state => state.logged,
        getCreateStatus: state => state.create.status,
        getUpdateStatus: state => state.update.status,
        getDeleteStatus: state => state.delete.status,
        getUser: state => state.get,
        getAllUsers: state => state.userList
    },
    mutations: {
        createLoading(state) {
            state.create.status = 'loading'
        },
        createError(state) {
            state.create.status = 'error'
        },
        createSuccess(state) {
            state.create.status = 'success'
        },
        updateLoading(state) {
            state.update.status = 'loading'
        },
        updateError(state) {
            state.update.status = 'error'
        },
        updateSuccess(state) {
            state.update.status = 'success'
        },
        deleteLoading(state) {
            state.delete.status = 'loading'
        },
        deleteError(state) {
            state.delete.status = 'error'
        },
        deleteSuccess(state) {
            state.delete.status = 'success'
        },
        getLoading(state) {
            state.user.status = 'loading'
        },
        getError(state) {
            state.user.status = 'error'
        },
        getSuccess(state, payload) {
            state.user.status = 'success'
            state.user.username = payload.data.data.username
            state.user.email = payload.data.data.email
            state.user.role = payload.data.data.role
        },
        getAllLoading(state) {
            state.userList.status = 'loading'
        },
        getAllError(state) {
            state.userList.status = 'error'
        },
        getallSuccess(state, payload) {
            state.userList.status = 'success'
            state.userList.data = payload.data.data
        }
    },
    actions: {
        createUserModule({ commit }, { username, email, firstname, lastname, password, role }) {
            commit('createLoading')
            userService.createUser(username, email, firstname, lastname, password, role).then(
                success => {
                    commit('createSuccess')
                },
                error => {
                    commit('createError')
                }
            )
        },
        updateUser({ commit }, { id, username, email, firstname, lastname, password, role }) {
            commit('updateLoading')
            userService.updateUser(id, username, email, firstname, lastname, password, role).then(
                success => {
                    commit('updateSuccess')
                },
                error => {
                    commit('updateError')
                }
            )
        },
        deleteUser({ commit }, { id }) {
            commit('deleteLoading')
            userService.deleteUser(id).then(
                success => {
                    commit('deleteSuccess')
                },
                error => {
                    commit('deleteError')
                }
            )
        },
        getUser({ commit }, { id }) {
            commit('getLoading')
            userService.getUser(id).then(
                success => {
                    commit('getSuccess', success)
                },
                error => {
                    commit('getError')
                }
            )
        },
        getAllUser({ commit }, { role }) {
            commit('getAllLoading')
            userService.getAllUsers(role).then(
                success => {
                    commit('getAllSuccess', success)
                },
                error => {
                    commit('getAllError')
                }
            )
        }
    }
}