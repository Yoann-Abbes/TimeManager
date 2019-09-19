<template>
    <div class="ClockManager">
        <h1> ClockManager  </h1>
           <span style="text"> {{refresh | chrono}} </span> <button @click.prevent="clock">clock</button>
    </div>
</template>

<script>
    import { clockManagerService } from "../_services/clockmanager.service";

    export default {
        data(){
            return {
                startDateTime: 0,
                currentTime: 0,
                status: false,
                interval: null
            }
        },
        computed: {
            getStatus(){
                return this.status
            },
            refresh(){
                const current = ((this.currentTime - this.startDateTime - 7200) >= 0) ? (this.currentTime - this.startDateTime - 7200) : 0
                return current
            }
        },
        methods:{
            clock(){
                clockManagerService.createClock(this.$root.user.id, !this.status).then(
                    success => {
                        if(this.status === false){
                            this.startInterval()
                        }else{
                            clearInterval(this.interval)
                        }
                        if(Array.isArray(success.data.data)){
                            this.startDateTime = this.dateToTimestamp(new Date(success.data.data[0].time))
                        }else{
                            this.startDateTime = this.dateToTimestamp(new Date(success.data.data.time))
                        }
                        this.status = !this.status
                    },
                    error => {
                        console.log(error)
                    }
                )
            },
            startInterval(){
                this.interval = setInterval(() => {
                    let dt = new Date()
                    dt.setHours(dt.getHours() + 2)
                    this.currentTime = this.dateToTimestamp(dt)
                }, 1000)
            },
            dateToTimestamp(d){
               return Math.round(d.getTime() / 1000);
            }
        },
        mounted() {
            clockManagerService.getClock(this.$root.user.id).then(
                success => {
                    if(Array.isArray(success.data.data)){
                        if(success.data.data.length > 0){
                            this.startDateTime = this.dateToTimestamp(new Date(success.data.data[0].time))
                            this.status = success.data.data[0].status
                            this.startInterval()
                        }

                    }else{
                        if(Object.keys(success.data.data).length > 0){
                            this.startDateTime = this.dateToTimestamp(new Date(success.data.data.time))
                            this.status = success.data.data.status
                            this.startInterval()
                        }
                    }


                },
                error => {
                    console.log(error)
                }
            )
        },
        filters:{
            chrono(value){

                let hour = Math.floor(value/3600)
                let min = Math.floor((value - hour*3600)/60)
                let sec = Math.floor(value - hour*3600 - min*60)

                hour = (hour > 9) ? hour : "0" + hour
                min = (min > 9) ? min : "0" + min
                sec = (sec > 9) ? sec : "0" + sec

                return hour + ":" + min + ": " + sec
            }
        },
        beforeDestroy () {
            clearInterval(this.interval)
        }
    }
</script>
