<template>
  <h1>Hello <slot></slot></h1>
</template>

<script>
export default {
  mounted () {
    console.log('Your first component Hello is mounted');
  }
}
</script>

<style scoped>
h1 { color: blue; }
</style>
