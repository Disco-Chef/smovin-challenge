<template>
  <ResultCard v-if="responseIs200" />
  <IndexationForm v-else />
</template>

<script>
import IndexationForm from './components/IndexationForm.vue'
import ResultCard from './components/ResultCard.vue'

export default {
  name: 'App',
  components: {
    IndexationForm,
    ResultCard
  },
  data() {
    return {
      responseIs200: false
    }
  }
}
</script>

<style>

</style>
