<template>
    <div class="WorkingTime">
        <md-dialog :md-click-outside-to-close="false" :md-active.sync="formDialog.showDialog" style="width:500px;min-height:500px" v-show="$root.user.status === 'success' && !!$route.params.userId && !!$route.params.workingtimeId">
            <md-dialog-title>Edit/Delete a workingTime</md-dialog-title>
            <md-dialog-content>
                Start: <datetime format="YYYY-MM-DD H:i:s" v-model="formDialog.start"></datetime>
                End: <datetime format="YYYY-MM-DD H:i:s" v-model="formDialog.end"></datetime>
            </md-dialog-content>
            <md-dialog-actions>
                <md-button class="md-danger" @click="$router.back()">Close</md-button>
                <md-button class="md-primary" @click="updateWorkingTime">Edit</md-button>
                <md-button class="md-primary" @click="deleteWorkingTime">Delete</md-button>
            </md-dialog-actions>
        </md-dialog>
        <!-- create workingTime form -->
        <md-dialog :md-click-outside-to-close="false" :md-active.sync="formDialog.showDialog" style="width:500px;min-height:500px" v-show="$root.user.status === 'success' && !!$route.params.userId && !$route.params.workingtimeId">
            <md-dialog-title>Create a workingTime</md-dialog-title>
            <md-dialog-content>
                Start: <datetime format="YYYY-MM-DD H:i:s" v-model="formDialog.start"></datetime>
                End: <datetime format="YYYY-MM-DD H:i:s" v-model="formDialog.end"></datetime>
            </md-dialog-content>
            <md-dialog-actions>
                <md-button class="md-danger" @click="$router.back()">Close</md-button>
                <md-button class="md-primary" @click="createWorkingTime">Create</md-button>
            </md-dialog-actions>
        </md-dialog>
        <!-- fin de create user form -->
    </div>
</template>

<script>
    import datetime from 'vuejs-datetimepicker'
    import{ workingTimesService } from '../_services/workingtimes.service'

    export default {
        components:{
            datetime
        },
        data(){
            return {
                formDialog:{
                    showDialog: true,
                    start: "",
                    end: ""
                }
            }
        },
        methods:{
            createWorkingTime(){
                const { start, end } = this.formDialog
                workingTimesService.createWorkingTime(this.$root.user.id, start, end).then(
                    success => {
                        this.$parent.getWorkingTimes()
                        this.$router.back()
                    },
                    error => {
                        console.log(error)
                    }
                )
            },
            updateWorkingTime(){
                const { start, end } = this.formDialog
                workingTimesService.updateWorkingTime(this.$route.params.workingtimeId, start, end).then(
                    success => {
                        this.$parent.getWorkingTimes()
                        this.$router.back()
                    },
                    error => {
                        console.log(error)
                    }
                )
            },
            deleteWorkingTime(){
                workingTimesService.deleteWorkingTime(this.$route.params.workingtimeId).then(
                    success => {
                        this.$parent.getWorkingTimes()
                        this.$router.back()
                    },
                    error => {
                        console.log(error)
                    }
                )
            },
        }
    }
</script>
