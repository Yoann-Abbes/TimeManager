<template>
  <div class="dashboard-general">
    <div v-if="getLoggedUser.status === 'error'">
      Not Found.
    </div>
    <div v-if="getLoggedUser.status === 'loading'">
      <md-progress-spinner :md-diameter="100" :md-stroke="10" md-mode="indeterminate"></md-progress-spinner>
    </div>
    <div v-show="getLoggedUser.status === 'success'">
      <employee v-if="getLoggedUser.role === 1" :user="getLoggedUser"/>
      <manager v-if="getLoggedUser.role === 2" :user="getLoggedUser"/>
      <general v-if="getLoggedUser.role === 3" :user="getLoggedUser"/>
    </div>
  </div>
</template>

<script>
  import employee from './Employee.dashboard'
  import manager from './Manager.dashboard'
  import general from './General_Manager.dashboard'

  export default {
    components:{
      employee,
      manager,
      general
    },
    computed: {
      getLoggedUser(){
        return (!this.$route.params.userId) ? this.$store.getters['userModule/getLoggedUser'] : this.$store.getters['userModule/getUser']
      }
    },
    watch:{
      $route (){
        if(this.$route.params.userId){
          const userId = this.$route.params.userId
          this.$store.dispatch('userModule/getUser', {id: userId})
        }else{
          this.$store.dispatch('userModule/getLoggedUser')
        }
      }
    },
    mounted(){
      if(this.$route.params.userId){
        const userId = this.$route.params.userId
        this.$store.dispatch('userModule/getUser', {id: userId})
      }else{
        this.$store.dispatch('userModule/getLoggedUser')
      }
    }
  }
</script>
