<template>
    <div class="WorkingTimes">
        <div v-show="$root.user.status === 'success'">
            <h1>Working times
                <router-link :to="{ name: 'workingTime.dialog', params: {userId: $root.getCurrentUser.id}}">
                    <md-icon>post_add</md-icon>
                </router-link>
            </h1>
            <md-table>
                <md-table-row>
                    <md-table-head md-numeric>ID</md-table-head>
                    <md-table-head>Start</md-table-head>
                    <md-table-head>End</md-table-head>
                </md-table-row>
                <md-table-row v-for="item in workingTimes.data" :key="item.id">
                    <md-table-cell md-numeric>{{item.id}}</md-table-cell>
                    <md-table-cell>{{ item.start | moment("MMMM Do YYYY, h:mm:ss") }}</md-table-cell>
                    <md-table-cell>{{ item.end | moment("MMMM Do YYYY, h:mm:ss") }}</md-table-cell>
                    <md-table-cell>
                            <router-link :to="{ name: 'workingTime.dialog', params: {userId: $root.getCurrentUser.id, workingtimeId: item.id, start: item.start, end: item.end}}">
                                <md-icon>edit</md-icon>
                            </router-link>
                    </md-table-cell>
                </md-table-row>
            </md-table>
        </div>
        <router-view></router-view>
    </div>
</template>

<script>
    import WorkingTime from "./WorkingTime"
    import {workingTimesService} from "../_services/workingtimes.service"

    export default {
        data(){
          return {
              workingTimes: {
                  data: []
              },
              dialogWorkingTimeShow: false
          }
        },
        methods: {
            getWorkingTimes(){
                workingTimesService.getWorkingTimes(this.$root.user.id).then(
                    success => {
                        this.workingTimes.data = success.data.data
                    },
                    error => {
                        this.workingTimes.data = error.data.data
                    }
                )
            },
        },
        mounted(){
            this.getWorkingTimes()
        }
    }
</script>
