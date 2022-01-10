# FindCVS

## Kakao Map API 설정

![스크린샷 2022-01-10 오후 1 50 14](https://user-images.githubusercontent.com/61230321/148719702-1fe3d136-9eb9-4573-96e9-54b200ed0f88.png)

- Download SDK를 통해 다운로드 받는다.

![스크린샷 2022-01-10 오후 1 51 09](https://user-images.githubusercontent.com/61230321/148719756-d8cc2978-9129-4490-8896-2ccb32467703.png)

- Kakao Developers로 가서 내 애플리케이션을 추가한다.

![스크린샷 2022-01-10 오후 1 51 56](https://user-images.githubusercontent.com/61230321/148719789-c832b307-94b6-4907-be26-faf4909164c7.png)

- 위 앱 키 중 네이티브 앱 키를 복사하여 info.plist에 KAKAO_API_KEY를 새로 만들어 복사 붙여넣기 한다.

![스크린샷 2022-01-10 오후 1 53 05](https://user-images.githubusercontent.com/61230321/148719843-ed9c0eb4-9a43-4a33-b806-87a89771c025.png)

- ios 플랫폼 등록을 통해 내가 생성한 프로젝트의 번들 ID를 저장한다.


![스크린샷 2022-01-10 오후 1 53 54](https://user-images.githubusercontent.com/61230321/148719879-623c951f-7bf1-42f6-ba9f-8215c38b76d5.png)

- 다운로드 받은 SDK 파일을 프로젝트에 추가한다.


![스크린샷 2022-01-10 오후 1 54 47](https://user-images.githubusercontent.com/61230321/148719912-68aa0478-024f-4367-91d4-a8c9d5723941.png)

- 프로젝트의 Build Phases의 Link Binday With Libraries에 여러 framework를 추가한다.
- 위치 정보와 같은 것은 기본으로 제공해주지 않기 때문에 필요함.


![스크린샷 2022-01-10 오후 1 55 49](https://user-images.githubusercontent.com/61230321/148719990-d29fcf39-73a8-4ee7-acd7-acaf71960801.png)

- Objective-c가 아닌 Swift를 사용하므로 bridging.h라는 헤더 파일을 생성하고 헤더 파일 안에 #import <DaumMap/MTMapView.h> 를 작성한다.




![스크린샷 2022-01-10 오후 1 57 28](https://user-images.githubusercontent.com/61230321/148720081-571b68fc-a1e1-4394-931c-f55f473bd3be.png)

- 프로젝트의 Build Settings > Appler Clang- Language - Objective-C 에서 Objective-C Automatic Reference Counting을 No로 변경

![스크린샷 2022-01-10 오후 2 00 01](https://user-images.githubusercontent.com/61230321/148720229-b584b874-1c43-4f73-8baa-104a17197e61.png)

- Target의 General에서 Swift Compiler - General > Objective-C Bridgind Header에 전에 만든 BridgingHeader.h의 full path를 저장


