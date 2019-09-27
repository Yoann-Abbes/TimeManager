<template>
    <div class="workingtimes">
        <div>
            <md-table class="column-table" style="max-height:390px">
                <md-table-row>
                    <md-table-head>Date</md-table-head>
                    <md-table-head>Start</md-table-head>
                    <md-table-head>End</md-table-head>
                    <md-table-head>Total (hour)</md-table-head>
                </md-table-row>
                <md-table-row :key="item.id" v-for="item in getWorkingTimes">
                    <md-table-cell>{{item.start | filterdate }}</md-table-cell>
                    <md-table-cell>{{item.start | filtertime}}</md-table-cell>
                    <md-table-cell>{{item.end | filtertime}}</md-table-cell>
                    <md-table-cell>{{ calculateTotal(item.start, item.end) }}</md-table-cell>
                </md-table-row>
            </md-table>
            <md-table class="row-table" style="max-height:390px">
                <md-table-row :key="item.id" v-for="item in getWorkingTimes" class="with-border-bottom">
                    <md-table-row><b>Date : </b> {{item.start | filterdate }}</md-table-row>
                    <md-table-row><b>Start : </b>{{item.start | filtertime}}</md-table-row>
                    <md-table-row><b>End : </b>{{item.end | filtertime}}</md-table-row>
                    <md-table-row><b>Total (hour) : </b>{{ calculateTotal(item.start, item.end) }}</md-table-row>
                </md-table-row>
            </md-table>
        </div>
    </div>
</template>

<script>
    export default {
        data(){
            return {

            }
        },
        computed:{
            getWorkingTimes(){
                return this.$store.getters['workingtimeModule/getWorkingTimes'].data
            }
        },
        methods:{
            calculateTotal(start, end){
                return this.diff_hours(new Date(start),new Date(end))
            },
            diff_hours(dt2, dt1){
                let diff =(dt2.getTime() - dt1.getTime()) / 1000
                diff /= (60 * 60)
                return Math.abs(Math.round(diff))
            }

        },
        filters:{
            filterdate(item){
                let newDate = new Date(item)
                let date = newDate.getFullYear() + "-" + ("0" + newDate.getMonth()).slice(-2) + "-" + ("0" + newDate.getDay()).slice(-2)
                return date
            },
            filtertime(item){
                let newDate = new Date(item)
                let time = ("0" + newDate.getHours()).slice(-2) + ":" + ("0" + newDate.getMinutes()).slice(-2) + ":" + ("0" + newDate.getSeconds()).slice(-2)
                return time
            }
        },
        mounted(){
            this.$store.dispatch('userModule/getLoggedUser').then(
                success => {
                    const userId = this.$store.getters['userModule/getLoggedUser'].id
                    this.$store.dispatch('workingtimeModule/getWorkingTimes', {userId})
                }
            )

        }
    }
</script>

