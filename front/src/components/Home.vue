<template>
  <div>
    HOME
    <button @click.prevent="logout">logout</button>
  </div>
</template>

<script>
export default {
  methods: {
    logout(){
      this.$store.dispatch('authModule/logout')
    }
  }
}
</script>
