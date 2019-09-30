import { workingTimesService } from "../../_services/workingtimes.service";

export const workingtimeModule = {
    namespaced: true,
    state:{
        workingtimes:{
            status: '',
            data: []
        },
        create: {
            status: ''
        },
        update: {
            status: ''
        },
        delete: {
            status: ''
        }
    },
    getters: {
        getWorkingTimes: state => state.workingtimes,
        getCreateStatus: state => state.create.status,
        getUpdateStatus: state => state.update.status,
        getDeleteStatus: state => state.delete.status
    },
    mutations: {
        workingtimesLoading(state){
            state.workingtimes.status = 'loading'
        },
        workingtimesError(state){
            state.workingtimes.status = 'error'
        },
        workingtimesSuccess(state, payload){
            state.workingtimes.status = 'success'
            state.workingtimes.data = payload.data.data
        },
        createLoading(state){
            state.create.status = 'loading'
        },
        createError(state){
            state.create.status = 'error'
        },
        createSuccess(state){
            state.create.status = 'success'
        },
        updateLoading(state){
            state.update.status = 'loading'
        },
        updateError(state){
            state.update.status = 'error'
        },
        updateSuccess(state){
            state.update.status = 'success'
        },
        deleteLoading(state){
            state.delete.status = 'loading'
        },
        deleteError(state){
            state.delete.status = 'error'
        },
        deleteSuccess(state){
            state.delete.status = 'success'
        },
    },
    actions: {
        getWorkingTimes({commit}, {userId}) {
            commit('workingtimesLoading')
            workingTimesService.getWorkingTimes(userId).then(
                success => {
                    commit('workingtimesSuccess', success)
                },
                error => {
                    commit('workingtimesError')
                }
            )
        },
        createWorkingTime({commit}, {userId, start, end}) {
            commit('createLoading')
            workingTimesService.createWorkingTime(userId, start, end).then(
                success => {
                    commit('createSuccess')
                },
                error => {
                    commit('createError')
                }
            )
        },
        updateWorkingTime({commit}, {id, start, end}) {
            commit('updateLoading')
            workingTimesService.updateWorkingTime(id, start, end).then(
                success => {
                    commit('updateSuccess')
                },
                error => {
                    commit('updateError')
                }
            )
        },
        deleteWorkingTime({commit}, {id}){
            commit('deleteLoading')
            workingTimesService.deleteWorkingTime(id).then(
                success => {
                    commit('deleteSuccess')
                },
                error => {
                    commit('deleteError')
                }
            )
        }
    }
}