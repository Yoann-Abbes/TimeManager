<template>
  <div id="app">
    <md-toolbar class="md-primary" md-elevation="1">
      <h3 class="md-title" style="flex: 1">Gotham</h3>
      <router-link to="/home">
        <md-button>
          <md-icon>home</md-icon>
        </md-button>
      </router-link>
      <div v-show="getLoggedUser.role === 2 || getLoggedUser.role === 3">
        <router-link  to="/register">
          <md-button>
            <md-icon>assignment_ind</md-icon>
          </md-button>
        </router-link>
      </div>
        <md-button v-show="getLoginStatus === 'success'" @click.prevent="logout">
          <md-icon>exit_to_app</md-icon>
        </md-button>
    </md-toolbar>
    <div style="padding:20px">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
 computed: {
   getLoggedUser(){
     return this.$store.getters['userModule/getLoggedUser']
   },
   getLoginStatus(){
     return this.$store.getters['authModule/getStatus']
   }
 },
  methods: {
   logout(){
     this.$store.dispatch('authModule/logout')
   }
  }
}
</script>