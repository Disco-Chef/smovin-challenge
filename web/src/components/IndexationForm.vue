<template>
    <form id="indexation-form" @submit.prevent="trySubmit" >
      <div class="row">
        <div class="form-group">
          <label>Contract Signed On</label>
          <Datepicker v-model="formParams.signedOn" :format="'yyyy/MM/dd'" :autoApply="true" :inputClassName="errorClassForSignedOn" />
        </div>
        <div class="form-group">
          <label>Rent Started On</label>
          <Datepicker v-model="formParams.startDate" :format="'yyyy/MM/dd'" :autoApply="true" :inputClassName="errorClassForStartDate" />
        </div>
      </div>
      <div class="row">
        <div class="form-group">
          <div id="region-input-label-pairs" :class="(submitting && missingRegion) ? 'invalid-input' : '' ">
            <div class="region-input-label-pair" :class="{activeRadioClass: activeRadio === 'brussels'}">
              <label for="brussels" @click="radioSelect('brussels')">Brussels</label>
              <input hidden type="radio" id="brussels" value="brussels" v-model="formParams.region" />
            </div>
            <div class="region-input-label-pair" :class="{activeRadioClass: activeRadio === 'flanders'}" >
              <label for="flanders" @click="radioSelect('flanders')">Flanders</label>
              <input hidden type="radio" id="flanders" value="flanders" v-model="formParams.region" />
            </div>
            <div class="region-input-label-pair" :class="{activeRadioClass: activeRadio === 'wallonia'}">
              <label for="wallonia" @click="radioSelect('wallonia')" >Wallonia</label>
              <input hidden type="radio" id="wallonia" value="wallonia" v-model="formParams.region"  />
            </div>
          </div>
        </div>
        <div class="form-group">
          <label>Rent</label>
          <input id="rent-label" type="text" v-model="formParams.baseRent" :class="errorClassForBaseRent" />
        </div>
      </div>
      <button>Get New Rent!</button>
      <template v-if="submitting">
        <p v-if="this.missingBaseRent" class="error-message">Rent cannot be blank</p>
        <p v-if="this.missingRegion" class="error-message">Region cannot be blank</p>
        <p v-if="this.missingSignedOn" class="error-message">Date contract was signed cannot be blank</p>
        <p v-if="this.missingStartDate" class="error-message">Rent start date cannot be blank</p>
        <p v-if="this.signedOnIsInFuture" class="error-message">Date the contract was signed on cannot be in the future</p>
        <p v-if="this.startDateIsInFuture" class="error-message">Rent start date cannot be in the future</p>
        <p v-if="this.startBeforeSign" class="error-message">Signed On date cannot be in the future of the rent Start Date</p>
        <p v-if="this.negativeOrZeroBaseRent" class="error-message">Rent must be positive</p>
        <p v-if="this.invalidRegion" class="error-message">Region must be one of : Brussels, Flanders, Wallonia</p>
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
      },
      activeRadio: ''
    };
  },
  components: {
    Datepicker
  },
  computed: {
    missingBaseRent() {
      return this.formParams.baseRent === '';
    },
    missingRegion() {
      return this.formParams.region === '';
    },
    missingSignedOn() {
      return this.formParams.signedOn === '';
    },
    missingStartDate() {
      return this.formParams.startDate === '';
    },
    startDateIsInFuture() {
      return this.formParams.startDate > new Date();
    },
    signedOnIsInFuture() {
      return this.formParams.signedOn > new Date();
    },
    startBeforeSign() {
      return this.formParams.startDate < this.formParams.signedOn;
    },
    negativeOrZeroBaseRent() {
      return parseInt(this.formParams.baseRent) <= 0;
    },
    formIsInvalid() {
      return this.missingBaseRent        ||
             this.missingRegion          ||
             this.missingSignedOn        ||
             this.missingStartDate       ||
             this.startDateIsInFuture    ||
             this.signedOnIsInFuture     ||
             this.startBeforeSign        ||
             this.negativeOrZeroBaseRent;
    },
    errorClassForBaseRent() {
      return (this.submitting && (this.missingBaseRent || this.negativeOrZeroBaseRent)) ? 'invalid-input' : '';
    },
    errorClassForSignedOn() {
      return (this.submitting && (this.missingSignedOn || this.signedOnIsInFuture || this.startBeforeSign)) ? 'invalid-input' : '';
    },
    errorClassForStartDate() {
      return (this.submitting && (this.missingStartDate || this.startDateIsInFuture || this.startBeforeSign)) ? 'invalid-input' : '';
    }
  },
  methods: {
    trySubmit() {
      this.submitting = true
      if (this.formIsInvalid) {
        return;
      }
      this.convertNonStringsToRightType();
      this.formParams = this.formatParamsForCall(this.formParams);
      this.$emit('give-valid-params-for-call:formParams', this.formParams);
      this.submitting = false;
    },
    convertNonStringsToRightType() {
      this.formParams.baseRent = parseInt(this.formParams.baseRent);
      this.formParams.signedOn = this.formParams.signedOn.toISOString().split('T')[0];
      this.formParams.startDate = this.formParams.startDate.toISOString().split('T')[0];
    },
    formatParamsForCall(formParams) {
      return {
        'base_rent': formParams.baseRent,
        'region': formParams.region.toLowerCase(),
        'signed_on': formParams.signedOn,
        'start_date': formParams.startDate
      };
    },
    radioSelect(region) {
      this.activeRadio = region;
    }
  }
}
</script>

<style scoped>
  #indexation-form {
    display: flex;
    flex-direction: column;
    width: 900px;
    justify-content: center;
    align-items: center;
  }
  .form-group {
    display: flex;
    flex-direction: column;
    align-items: center;
    font-size: 23px;

    width: 200px;
    height: 100%;
  }
  input {
    width: 230px;
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
    font-size: 24px;
    width: 300px;
  }
  .row {
    display: flex;
    width: 70%;
    justify-content: space-around;
    margin-bottom: 15px;
  }
  .invalid-input {
    border: medium solid red;
  }
  .error-message {
    color: rgb(227, 0, 0);
    font-weight: bold;
    font-size: 18px;
  }
  input[type=text] {
    font-size: inherit;
  }
  .activeRadioClass {
    background-color: #2bac6d;
  }
  #region-input-label-pairs {
    display: flex;
    flex-direction: column;
    width: 100%;
  }
  .region-input-label-pair {
    border: thin solid #2bac6d;
  }
  #rent-label{
    width: 100px;
  }
  .region-input-label-pair > label {
    display: block;
    width: 100%;
  }
</style>

<style>
  .invalid-input {
    border: medium solid red;
  }
</style>
