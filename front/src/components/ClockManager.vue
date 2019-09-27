<template>
    <div class="ClockManager" style="width:100%">
        <div v-show="getClock.status === 'loading'">
            <md-progress-spinner :md-diameter="100" :md-stroke="10" md-mode="indeterminate"></md-progress-spinner>
        </div>
        <div class="chrono-content" style="width:100%" v-show="getClock.status === 'success'">
            <h2>Report Daily work</h2>
            <div class="chrono-time">
                <span>{{refresh | chrono}}</span>
            </div>
            <div v-if="!$route.params.userId">
                <button @click.prevent="clock">{{ (getClock.boolean === false) ? 'clock in' : 'clock out'}}</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data(){
            return {

            }
        },
        props: ['user'],
        computed: {
            getClock(){
                return this.$store.getters['clockModule/getCurrentClock']
            },
            refresh(){
                return this.$store.getters['clockModule/getRefreshTime']
            },
            getBool(){
                return this.$store.getters['clockModule/getBool']
            }
        },
        methods:{
            clock(){
                const userId = this.user.id
                this.$store.dispatch('clockModule/createClock',{userId})
            }
        },
        mounted() {
            const userId = this.user.id
            this.$store.dispatch('clockModule/getClock',{userId})
        },
        filters:{
            chrono(value){

                let hour = Math.floor(value/3600)
                let min = Math.floor((value - hour*3600)/60)
                let sec = Math.floor(value - hour*3600 - min*60)

                hour = (hour > 9) ? hour : "0" + hour
                min = (min > 9) ? min : "0" + min
                sec = (sec > 9) ? sec : "0" + sec

                return hour + ":" + min + ":" + sec
            }
        },
        beforeDestroy () {
            this.$store.dispatch('clockModule/resetInterval')
        }
    }
</script>

<style>
    html{
        box-sizing: border-box;
    }
    .chrono-content{
        text-align: center;
    }
    .chrono-time{
        height:50px;
        position:relative;
        font-size: 50px;
        margin-bottom:5px;
    }
</style>