<template>
    <div id="chartManager" style="width:100%" v-show="getStatus === 'success'">
        <h1>Chart Manager</h1>
        <bar-chart
                id="data"
                :data="getWorkingTimes"
                xkey="date"
                resize="true"
                ykeys='["hour"]'
                ymin="0"
                ymax="24"
                labels='["hour"]'
                line-colors='["#576277"]'
                hide-hover="auto"
        />
    </div>
</template>
<script>
    import { BarChart } from 'vue-morris'

    export default {
        components: {
            BarChart
        },
        props: ['user'],
        computed: {
            getStatus(){
              return this.$store.getters['workingtimeModule/getWorkingTimes'].status
            },
            getWorkingTimes(){
                let data = this.$store.getters['workingtimeModule/getWorkingTimes'].data
                data = data.sort(this.SortTime).map(n => {
                    const d = new Date(n.start)
                    const e = new Date(n.end)
                    return {date: d.getFullYear() + "-" + d.getMonth() + "-" + d.getDay(), hour: this.diffTime(d, e)}
                })
                return data
            }
        },
        methods: {
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
            const id = this.user.id
            this.$store.dispatch('workingtimeModule/getWorkingTimes', {userId: id})
        }
    }
</script>

<style>
    #data {
        width: 100%;
    }
    svg {
        width: 100%;
    }
</style>