<template>
  <div id="result-card">
    <h1>New Indexed Rent Result</h1>
    <div id="image-container" :class="(betterNewRent) ? 'happy-user' : 'unhappy-user'"></div>
    <div id="regular-text">New rent you could legally demand from your rentees can be up to: <span id="new-rent">{{ newRentData.newRent }} Eur </span></div>
    <h2>Here's the formula breakdown:</h2>
    <div class="flexing-between">
      <div class="larger-titles">Base rent </div>
      <div class="values">({{ newRentData.baseRent }})</div>
      <div class="larger-titles"> X </div>
      <div class="larger-titles">Current index</div>
      <div class="values">({{ newRentData.currentIndex }})</div>
    </div>
    <div class="flexing-around">
      <div class="larger-titles">Base Index</div>
      <div class="values">({{ newRentData.baseIndex }})</div>
    </div>
    <button id="new-indexation-button" @click="requestNewIndexation">New Indexation!</button>
  </div>
</template>

<script>
export default {
  name: 'ResultCard',
  props: {
    newRentData: Object
  },
  computed: {
    betterNewRent() {
      return this.newRentData.newRent > this.newRentData.baseRent
    }
  },
  methods: {
    requestNewIndexation() {
      this.$emit('new-indexation')
    }
  }
}
</script>

<style scoped>
  #regular-text {
    font-size: 25px;
    font-weight: bold;
    margin-bottom: 35px;
  }
  #new-rent {
    font-family: cursive;
    font-size: 32px;
    font-weight: bold;
  }
  .flexing-between {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid;
  }
  .flexing-around {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .larger-titles {
    font-size: 32px;
    font-weight: bold;
  }
  .values {
    font-size: 25px;
    margin: 0px 8px;
    font-weight: bold;
  }
  h1 {
    text-align: center;
  }
  #image-container {
    width: 100%;
    height: 400px;
    background-position: center;
    background-size: cover;
  }
  .happy-user {
    background-image: url("https://media.giphy.com/media/2Faz8bcnGfXVrV2ZG/giphy.gif");
  }
  .unhappy-user {
    background-image: url("https://media.giphy.com/media/g0yIdv98lVqsyNAqn7/giphy.gif");
  }
  #new-indexation-button {
    background-color: #2bac6d;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
  }
</style>
