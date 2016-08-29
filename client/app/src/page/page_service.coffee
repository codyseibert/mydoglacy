module.exports = [
  'lodash'
  'localStorageService'
  (
    _
    localStorageService
  ) ->

    # page = localStorageService.get 'page'
    page =
      pet:
        name: 'Lacy'
        gender: 'Male'
        breed: 'Golden Retriever'
        date_of_birth: new Date()
        date_of_rest: new Date()
      banner: 'assets/images/dog-main.jpeg'
      memory: 'Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra.'
      biography: 'Pellentesque habitant molibero sit amet quam egestas semper. Aenean ultricies mi vitae est. Aenean ultricies mi vitae est.'
      imageA: 'assets/images/dog1.png'
      imageB: 'assets/images/dog2.png'
      imageC: 'assets/images/dog3.png'
      imageD: 'assets/images/dog4.png'
      imageE: 'assets/images/dog5.png'
      carousel: [
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ]
      options:
        facebook:
          share: false
          comments: false
        twitter:
          share: false

]
