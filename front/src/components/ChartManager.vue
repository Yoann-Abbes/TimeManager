<template>
    <div id="app" v-show="$root.user.status === 'success'">
        <h1>Chart Manager</h1>
        <bar-chart
                id="data"
                :data="data"
                xkey="date"
                resize="true"
                ykeys='["hour"]'
                ymin="0"
                ymax="24"
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
            },
            diffTime(a,b){
                let diff =(a.getTime() - b.getTime()) / 1000;
                diff /= (60 * 60);
                return Math.abs(Math.round(diff));
            }
        },
        mounted(){
            workingTimesService.getWorkingTimes(this.$root.user.id).then(
                success => {
                    const data = success.data.data.sort(this.SortTime)
                    this.data = data.map(n => {
                        const d = new Date(n.start)
                        const e = new Date(n.end)
                        return {date: d.getFullYear()+"-"+d.getMonth()+"-"+d.getDay(), hour: this.diffTime(d,e)}
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