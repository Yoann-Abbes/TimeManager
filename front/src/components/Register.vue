<template>
  <div class="register">
    <div class="centered-container">
      <md-content class="md-elevation-3">
        <div class="title">
          <div class="md-title">Register</div>
          <p v-if="errors.length">
            <b>Please correct the following error(s):</b>
            <br />
            {{ errors }}
          </p>
        </div>

        <div class="form">
          <md-field>
            <label>Username</label>
            <md-input v-model="registerForm.username"></md-input>
          </md-field>
          <md-field>
            <label>Firstname</label>
            <md-input v-model="registerForm.firstname"></md-input>
          </md-field>
          <md-field>
            <label>Lastname</label>
            <md-input v-model="registerForm.lastname"></md-input>
          </md-field>
          <md-field>
            <label>E-mail</label>
            <md-input autofocus v-model="registerForm.email"></md-input>
          </md-field>
          <md-field md-has-password>
            <label>Password</label>
            <md-input v-model="registerForm.password" type="password"></md-input>
          </md-field>
          <md-field>
            <label>Role (1, 2 ou 3)</label>
            <md-input v-model="registerForm.role"></md-input>
          </md-field>
        </div>

        <div class="actions md-layout md-alignment-center-space-between">
          <md-button class="md-raised md-primary" @click="registerUser">Register</md-button>
        </div>
      </md-content>
      <div class="background" />
    </div>
  </div>
</template>

<script>
//import { loginService } from "../_services/login.service";
import { mapActions, mapGetters } from "vuex";
//import ...mapAction ({'test'}),
import store from "../_store/index.js";

//store.
export default {
  store: store,
  data() {
    return {
      errors: "",
      registerForm: {
        email: "",
        username: "",
        password: "",
        lastname: "",
        firstname: "",
        role: ""
      }
    };
  },
  computed: {
    ...mapGetters(["todo"])
  },
  methods: {
    ...mapActions(["registerUser", "createUserModule"]),
    registerUser: function() {
      //this.registerUserModule("tamere");
      const {
        email,
        username,
        password,
        lastname,
        firstname,
        role
      } = this.registerForm;
      this.errors = "";

      if (!password) this.errors += "password required.";
      else this.errors = "";
      if (!username) this.errors += "Username required.";
      if (!lastname) this.errors += "Lastname required.";
      if (!firstname) this.errors += "Firstname required.";
      if (!role) this.errors += "Role required.";
      if (!email || !this.validEmail(email))
        this.errors += " Valid email required.";
      
      if (!this.errors.length) {
        this.$store.dispatch('userModule/createUserModule', {username: username, email: email, firstname: firstname, lastname: lastname, password: password, role: role})        
        //this.createUserModule(username, email, firstname, lastname, password, role).then(
        //  success => {
        //    console.log(success);
        //  },
        //  error => {
        //    console.error(error);
        //  }
        //);
      }
    },
    validEmail: function(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    }
  }
};
/* eslint-disable */
</script>

<style>
.centered-container {
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  height: 100vh;
}
.title {
  text-align: center;
  margin-bottom: 30px;
}
.form {
  margin-bottom: 60px;
}
.md-content {
  padding: 40px;
}
</style>
