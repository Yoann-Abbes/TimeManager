<template>
  <div>
    HOME
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
