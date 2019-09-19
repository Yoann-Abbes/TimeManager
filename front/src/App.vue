<template>
  <div id="app">
    <md-toolbar class="md-primary" md-elevation="1">
      <h3 class="md-title" style="flex: 1">Gotham</h3>
      <router-link to="/home">
        <md-button>
          <md-icon>home</md-icon>
        </md-button>
      </router-link>
      <router-link to="/register">Register</router-link>
    </md-toolbar>
    <div style="padding:20px">
      <!--<Login/>-->
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
//import User from './components/User.vue'
import Login from "./components/Login";
import Register from "./components/Register";

export default {
  name: "app"
  //components: {
  //    Login,
  //    Register
  //}
};
</script>