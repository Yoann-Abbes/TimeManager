<template>
    <div class="profile">
        <h1>Profile</h1>
        <md-list>
            <md-list-item>
                <span class="md-list-item-text">Username : {{getLoggedUser.username}}</span>
            </md-list-item>
            <md-list-item>
                <span class="md-list-item-text">firstname : {{getLoggedUser.firstname}}</span>
            </md-list-item>
            <md-list-item>
                <span class="md-list-item-text">lastname : {{getLoggedUser.lastname}}</span>
            </md-list-item>
            <md-list-item>
                <span class="md-list-item-text">role : {{role[getLoggedUser.role][0]}}</span>
            </md-list-item>
            <md-list-item>
                <span class="md-list-item-text">email : {{getLoggedUser.email}}</span>
            </md-list-item>
        </md-list>
        <div>
            <md-button class="md-raised md-primary" @click.prevent="openEditDialog()">Edit</md-button>
            <md-button class="md-raised md-accent" @click.prevent="deletion.showDeleteDialog = true">Delete Account</md-button>
        </div>
        <div>
            <md-dialog :md-active.sync="edit.showEditDialog" style="padding:10px">
                <md-dialog-title>Edit profile</md-dialog-title>
                <md-field>
                    <label>Username</label>
                    <md-input type="text" required autofocus v-model="edit.username"></md-input>
                </md-field>
                <md-field>
                    <label>Firstname</label>
                    <md-input type="text" required autofocus v-model="edit.firstname"></md-input>
                </md-field>
                <md-field>
                    <label>Lastname</label>
                    <md-input type="text" required autofocus v-model="edit.lastname"></md-input>
                </md-field>
                <md-field>
                    <label>Email</label>
                    <md-input type="text" required autofocus v-model="edit.email"></md-input>
                </md-field>
                <md-dialog-actions>
                    <md-button class="md-accent" @click="edit.showEditDialog = false">Close</md-button>
                    <md-button class="md-primary" @click="confirmEditDialog()">Confirm</md-button>
                </md-dialog-actions>
            </md-dialog>
        </div>
        <div>
            <md-dialog :md-active.sync="deletion.showDeleteDialog" style="padding:10px">
                <md-dialog-title>Edit profile</md-dialog-title>
                <span> Are you sure to delete your account ? </span>
                <md-dialog-actions>
                    <md-button class="md-accent" @click="deletion.showDeleteDialog = false">Close</md-button>
                    <md-button class="md-primary" @click="confirmDeleteDialog()">Confirm deletion</md-button>
                </md-dialog-actions>
            </md-dialog>
        </div>

    </div>
</template>

<script>
    export default {
        data(){
            return {
                edit: {
                    showEditDialog: false,
                    id: '',
                    username: '',
                    firstname: '',
                    lastname: '',
                    email: ''
                },
                deletion: {
                  showDeleteDialog: false
                },
                role: [
                    [],
                    ['Employee'],
                    ['Manager'],
                    ['Global Manager']
                ]
            }
        },
        computed:{
            getLoggedUser(){
                return this.$store.getters['userModule/getLoggedUser']
            }
        },
        methods:{
            openEditDialog(){
                const getCurrentUser = this.$store.getters['userModule/getLoggedUser']
                this.edit = {
                    id: getCurrentUser.id,
                    username: getCurrentUser.username,
                    firstname: getCurrentUser.firstname,
                    lastname: getCurrentUser.lastname,
                    email: getCurrentUser.email,
                    showEditDialog: true
                }

            },
            confirmEditDialog(){
                const {id, username, firstname, lastname, email} = this.edit
                this.$store.dispatch('userModule/updateUser', {id, username, firstname, lastname, email}).then(
                    success => {
                        this.edit.showEditDialog = false
                    }
                )
            },
            confirmDeleteDialog(){
                const id = this.$store.getters['userModule/getLoggedUser'].id
                this.$store.dispatch('userModule/deleteUser', {id}).then(
                    success => {
                        this.$store.dispatch('authModule/logout')
                    }
                )
            }
        }
    }
</script>