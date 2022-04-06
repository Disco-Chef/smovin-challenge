<template>
    <form id="indexation-form" @submit.prevent="trySubmit" >
      <div class="row">
        <div class="form-group">
          <label>Contract Signed On</label>
          <Datepicker v-model="formParams.signedOn" :format="'yyyy/MM/dd'" :autoApply="true" :inputClassName="(submitting && (missingSignedOn || signedOnIsInFuture || startBeforeSign)) ? 'invalid-input' : '' " />
        </div>
        <div class="form-group">
          <label>Rent Started On</label>
          <Datepicker v-model="formParams.startDate" :format="'yyyy/MM/dd'" :autoApply="true" :inputClassName="(submitting && (missingStartDate || startDateIsInFuture || startBeforeSign)) ? 'invalid-input' : '' " />
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <label>Region (Brussels | Flanders | Wallonia)</label>
          <input type="text" v-model="formParams.region" :class="(submitting && (missingRegion || invalidRegion)) ? 'invalid-input' : '' " />
        </div>
        <div class="form-group">
          <label>Rent</label>
          <input type="text" v-model="formParams.baseRent" :class="(submitting && (missingBaseRent || negativeOrZeroBaseRent)) ? 'invalid-input' : '' " />
        </div>
      </div>
      <button>Get New Rent!</button>
      <template v-if="submitting">
        <p v-if="this.missingBaseRent" class="error-message">Rent is blank</p>
        <p v-if="this.missingRegion" class="error-message">Region is blank</p>
        <p v-if="this.missingSignedOn" class="error-message">Date contract was signed is blank</p>
        <p v-if="this.missingStartDate" class="error-message">Rent start date is blank</p>
        <p v-if="this.signedOnIsInFuture" class="error-message">Date contract was signed on cannot be in the future</p>
        <p v-if="this.startDateIsInFuture" class="error-message">Rent start date cannot be in the future</p>
        <p v-if="this.startBeforeSign" class="error-message">Signed On date cannot be in the future of the rent Start Date </p>
        <p v-if="this.negativeOrZeroBaseRent" class="error-message">Rent must be positive 🔎 </p>
        <p v-if="this.invalidRegion" class="error-message">Region must be one of : Brussels, Flanders, Wallonia </p>
      </template>
    </form>
</template>

<script>
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
  name: 'IndexationForm',
  data () {
    return {
      submitting: false,
      formParams: {
        baseRent: '',
        region: '',
        signedOn: '',
        startDate: '',
      }
    }
  },
  methods: {
    trySubmit() {
      this.submitting = true
      if (this.formIsInvalid) {
        return
      }
      this.convertNonStringsToRightType()
      this.formParams = this.formatParamsForCall(this.formParams)
      this.$emit('give-valid-params-for-call:formParams', this.formParams);
      this.resetForm()
      this.submitting = false
    },
    convertNonStringsToRightType() {
      this.formParams.baseRent = parseInt(this.formParams.baseRent)
      this.formParams.signedOn = this.formParams.signedOn.toISOString().split('T')[0]
      this.formParams.startDate = this.formParams.startDate.toISOString().split('T')[0]
    },
    resetForm() {
      this.formParams = {
        baseRent: '',
        region: '',
        signedOn: '',
        startDate: '',
      }
    },
    formatParamsForCall(formParams) {
      return {
        'base_rent': formParams.baseRent,
        'region': formParams.region.toLowerCase(),
        'signed_on': formParams.signedOn,
        'start_date': formParams.startDate
      }
    }
  },
  components: {
    Datepicker
  },
  computed: {
    missingBaseRent() {
      return this.formParams.baseRent === ''
    },
    missingRegion() {
      return this.formParams.region === ''
    },
    missingSignedOn() {
      return this.formParams.signedOn === ''
    },
    missingStartDate() {
      return this.formParams.startDate === ''
    },
    startDateIsInFuture() {
      return this.formParams.startDate > new Date()
    },
    signedOnIsInFuture() {
      return this.formParams.signedOn > new Date()
    },
    startBeforeSign() {
      return this.formParams.startDate < this.formParams.signedOn
    },
    negativeOrZeroBaseRent() {
      return parseInt(this.formParams.baseRent) <= 0
    },
    invalidRegion() {
      return !["brussels", "Brussels", "flanders", "Flanders", "wallonia", "Wallonia"].includes(this.formParams.region)
    },
    formIsInvalid() {
      return this.missingBaseRent        ||
             this.missingRegion          ||
             this.missingSignedOn        ||
             this.missingStartDate       ||
             this.startDateIsInFuture    ||
             this.signedOnIsInFuture     ||
             this.startBeforeSign        ||
             this.negativeOrZeroBaseRent ||
             this.invalidRegion
    }
  }
}
</script>

<style scoped>
  #indexation-form {
    display: flex;
    flex-direction: column;
    width: 100%;
    justify-content: center;
  }
  .form-group {
    display: flex;
    flex-direction: column;
    text-align: center;
    font-size: 24px;
    width: 400px;
  }
  label {
    width: 100%;
  }
  input {
    width: 100%;
    height: 35px;
  }
  button {
    background-color: #2bac6d;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
  }
  .row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
  }
  .invalid-input {
    border: medium solid red;
  }
  .error-message {
    color: red;
  }
</style>

<style>
  .invalid-input {
    border: medium solid red;
  }
</style>
