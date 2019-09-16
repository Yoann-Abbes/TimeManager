<template>
    <div class="ClockManager">
        <h1> ClockManager  </h1>
        <div v-if="!!getStatus">
            on affiche
        </div>
        <div v-else>
            on affiche pas
        </div>
    </div>
</template>

<script>
    import { clockManagerService } from "../_services/clockmanager.service";

    export default {
        data(){
            return {
                startDateTime: null,
                status: false
            }
        },
        computed: {
            getStatus(){
                return this.status
            }
        },
        methods:{
            refresh(){

            },
            clock(){
                clockManagerService.updateClock(this.$root.user.id, this.startDateTime, this.status).then(
                    success => {
                        this.startDateTime = success.data.data.time
                        this.status = success.data.data.status
                    },
                    error => {
                        console.log(error)
                    }
                )
            }
        },
        mounted() {
            clockManagerService.getClock(this.$root.user.id).then(
                success => {
                    this.startDateTime = success.data.data.time;
                    this.status = success.data.data.status
                },
                error => {
                    clockManagerService.createClock(this.$root.user.id).then(
                        success => {
                            this.startDateTime = success.data.data.time
                            this.status = success.data.data.status
                        },
                        error => {
                            console.log(error)
                        }
                    )
                }
            )
            this.interval = setInterval(this.refresh, 1000)
        }
    }
</script>
