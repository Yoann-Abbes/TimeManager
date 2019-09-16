<template>
    <div id="app">
        <h1>Chart Manager</h1>
        <bar-chart
                id="data"
                :data="data"
                xkey="date"
                resize="true"
                ykeys='["hour"]'
                labels='["hour"]'
                line-colors='["#576277"]'
                hide-hover="auto"
        >
        </bar-chart>
    </div>
</template>
<script>
    import { BarChart } from 'vue-morris'
    import {workingTimesService} from '../_services/workingtimes.service'

    export default {
        name: 'app',
        data () {
            return {
                data: []
            }
        },
        components: {
            BarChart
        },
        methods:{
            SortTime(a,b){
                const da=new Date(a.start);
                const db=new Date(b.start);
                return (da>db)?1:-1;
            }
        },
        mounted(){
            workingTimesService.getWorkingTimes(this.$root.user.id).then(
                success => {
                    const data = success.data.data.sort(this.SortTime)

                    this.data = data.map(n => {
                        const d = new Date(n.start)
                        return {date: d.getFullYear()+"-"+d.getMonth()+"-"+d.getDay(), hour: d.getHours()}
                    })
                    console.log(this.data)
                },
                error => {
                    console.log(error)
                }
            )
        }
    }
</script>