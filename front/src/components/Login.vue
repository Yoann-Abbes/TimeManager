<template>
  <div class="login">
    <div class="centered-container">
      <md-content class="md-elevation-3">
        <div class="title">
          <div class="md-title">Please connect with your personal account</div>
          <p v-if="errors.length">
            <b>Please correct the following error(s):</b>
            <br />
            {{ errors }}
          </p>
        </div>

        <div class="form">
          <md-field>
            <label>E-mail</label>
            <md-input autofocus v-model="loginForm.email"></md-input>
          </md-field>

          <md-field md-has-password>
            <label>Password</label>
            <md-input v-model="loginForm.password" type="password"></md-input>
          </md-field>
        </div>

        <div class="actions md-layout md-alignment-center-space-between">
          <md-button class="md-raised md-primary" @click="loginUser">Log in</md-button>
          <md-button class="md-raised md-primary" @click="loginUser">Register</md-button>
        </div>
      </md-content>
      <div class="background" />
    </div>
  </div>
</template>

<script>
import { loginService } from "../_services/login.service";

export default {
  data() {
    return {
      errors: "",
      loginForm: {
        email: "",
        password: ""
      }
    };
  },
  methods: {
    loginUser: function() {
      const { email, password } = this.loginForm;
      this.errors = "";
      if (!password) this.errors += "password required.";
      else this.errors = "";
      if (!email || !this.validEmail(email))
        this.errors += " Valid email required.";
      if (!this.errors.length)
        loginService.loginUser(email, password).then(
          success => {
            console.log(success);
          },
          error => {
            console.error(error);
          }
        );
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
