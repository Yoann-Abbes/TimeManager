import { userService } from '../../_services/user.service'

export const userModule = {
    namespaced: true,
    state: {
        logged: {
            status: '',
            id: '',
            username: '',
            email: '',
            firstname: '',
            lastname: '',
            role: '',
            team: ''
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
            firstname: '',
            lastname: '',
            role: '',
            team: ''
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
        updateSuccess(state, payload) {
            state.update.status = 'success'
            state.logged.id = payload.data.data.id
            state.logged.username = payload.data.data.username
            state.logged.firstname = payload.data.data.firstname
            state.logged.lastname = payload.data.data.lastname
            state.logged.email = payload.data.data.email
            state.logged.role = payload.data.data.role_id
            state.logged.team = payload.data.data.team
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
            state.get.status = 'loading'
        },
        getError(state) {
            state.get.status = 'error'
        },
        getSuccess(state, payload) {
            state.get.status = 'success'
            state.get.id = payload.data.data.id
            state.get.username = payload.data.data.username
            state.get.firstname = payload.data.data.firstname
            state.get.lastname = payload.data.data.lastname
            state.get.email = payload.data.data.email
            state.get.role = payload.data.data.role_id
            state.get.team = payload.data.data.team
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
        },
        getLoggedLoading(state) {
            state.logged.status = 'loading'
        },
        getLoggedError(state) {
            state.logged.status = 'error'
        },
        getLoggedSuccess(state, payload) {
            state.logged.status = 'success'
            state.logged.id = payload.data.data.id
            state.logged.username = payload.data.data.username
            state.logged.firstname = payload.data.data.firstname
            state.logged.lastname = payload.data.data.lastname
            state.logged.email = payload.data.data.email
            state.logged.role = payload.data.data.role_id
            state.logged.team = payload.data.data.team
        }
    },
    actions: {
        createUser({ commit }, { username, email, firstname, lastname, password, role}) {
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
        updateUser({ commit }, { id, username, email, firstname, lastname}) {
            commit('updateLoading')
            userService.updateUser(id, username, email, firstname, lastname).then(
                success => {
                    commit('updateSuccess', success)
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
        async getUser({ commit }, { id }) {
            commit('getLoading')
            await userService.getUser(id).then(
                success => {
                    console.log(success)
                    commit('getSuccess', success)
                },
                error => {
                    commit('getError')
                }
            )
        },
        async getLoggedUser({commit}){
            commit('getLoggedLoading')
            await userService.getLoggedUser().then(
                success => {
                    commit('getLoggedSuccess', success)
                },
                error => {
                    commit('getLoggedError')
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