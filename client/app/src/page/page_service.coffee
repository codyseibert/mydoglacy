module.exports = [
  'lodash'
  'localStorageService'
  (
    _
    localStorageService
  ) ->

    page = localStorageService.get 'page'
    page ?=
      pet:
        name: 'Lacy'
        gender: 'Male'
        breed: 'Golden Retriever'
        date_of_birth: new Date()
        date_of_rest: new Date()
      banner: 'assets/images/dog-main-min.png'
      memory: 'Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet .'
      biography: 'Pellentesque habitant molibero sit amet quam egestas semper. Aenean ultricies mi vitae est. Aenean ultricies mi vitae est.'
      titleA: "Lacy Look'n Legit"
      snippitA: "Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit"
      story: """
        <h1>Lacy's Story</h1>
        <p>Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. </p>
        <p>Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. </p>
      """
      titleB: "What a Babe"
      snippitB: "Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam"
      imageA: 'assets/images/dog1.png'
      imageB: 'assets/images/dog2.png'
      imageC: 'assets/images/dog3.png'
      imageD: 'assets/images/dog4.png'
      imageE: 'assets/images/dog5.png'
      imageF: 'assets/images/dog5.png'
      imageG: 'assets/images/dog5.png'
      imageH: 'assets/images/dog5.png'
      imageI: 'assets/images/dog5.png'
      imageJ: 'assets/images/dog5.png'
      carousel: [
        image: 'assets/images/dog-main-min.png'
      ,
        image: 'assets/images/dog5.png'
      ,
        image: 'assets/images/dog1.png'
      ,
        image: 'assets/images/dog2.png'
      ,
        image: 'assets/images/dog3.png'
      ,
        image: 'assets/images/dog-main-min.png'
      ,
        image: 'assets/images/dog4.png'
      ,
        image: 'assets/images/dog5.png'
      ,
        image: 'assets/images/dog2.png'
      ,
        image: 'assets/images/dog3.png'
      ,
        image: 'assets/images/dog3.png'
      ,
        image: 'assets/images/dog3.png'
      ]
      options:
        facebook:
          share: false
          comments: false
        twitter:
          share: false

]
