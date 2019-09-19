import { registerService } from '../../_services/register.service'

const state = {
    todo: "toto"
}

export const registerModule = {
    state: state,
    mutation: {
        newTodo(state, todo) {
            state.todo = todo
        },
    },
    getters: { todo: state => state.todo },
    actions: {
        registerUserModule({ commit }, { username, email, firstname, lastname, password, role }) {
            console.log("CDSSSSSSSSSsSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
                //commit('createLoading')
            registerService.registerUser(username, email, firstname, lastname, password, role).then(
                success => {
                    commit('registerSuccess')
                },
                error => {
                    commit('registerError')
                }
            )
        },
        updateTodo({ commit }, todo) {
            //commit('newTodo', todo);
        }
    }
}