<template>
  <ResultCard v-if="successfulCall" :newRentData="newRentData"  @new-indexation="startNewIndexation" />
  <IndexationForm v-else @show-results="showResultCard" />
</template>

<script>
import IndexationForm from './components/IndexationForm.vue';
import ResultCard from './components/ResultCard.vue';

export default {
  name: 'App',
  data() {
    return {
      successfulCall: false,
      newRentData: {}
    };
  },
  components: {
    IndexationForm,
    ResultCard
  },
  methods: {
    startNewIndexation() {
      this.$confetti.stop();
      this.successfulCall = false
    },
    showResultCard (results) {
      this.newRentData = results;
      this.successfulCall = true;
    }
  }
}
</script>

<style>
  #app {
    margin-top: 35px;
    display: flex;
    justify-content: center;
  }
  body {
    text-align: center;
    background-color: lightblue;
    display: flex;
    justify-content: center;
  }
</style>
