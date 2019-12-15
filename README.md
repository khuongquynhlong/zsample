# Package "zsample" cho Stata

Package tính cỡ mẫu cho Stata, được viết bởi PGS.TS.BS Đỗ Văn Dũng - Đại Học Y Dược TP.HCM

<br>
<br>

__Nội dung__  
1. [Cài đặt gói](#1-Cài-đặt-gói)
2. [Cỡ mẫu ước lượng 1 tỉ lệ](#2-Cỡ-mẫu-ước-lượng-1-tỉ-lệ)
3. [Cỡ mẫu ước lượng 1 trung bình](#3-Cỡ-mẫu-ước-lượng-1-trung-bình)
4. [Một số chức năng khác - đang update](#4-Một-số-chức-năng-khác)


# 1. Cài đặt gói
Để cài đặt gói, gõ câu lệnh sau vào STATA 

Chú ý: máy tính cần kết nối internet để cài được gói

```{js}
net install zsample, from("https://khuongquynhlong.github.io/zsample/")
```

Sau khi cài đặt xong, gói có thể sử dụng được


# 2. Cỡ mẫu ước lượng 1 tỉ lệ

Để sử dụng công thức tính cỡ mẫu cho ước lượng 1 tỉ lệ, vào STATA gõ 

```{js}
db zpsampsi
```
Hộp thoại mở ra, chọn các thông số và nhấn ok. Các thông số bao gồm

`proportion`: tỉ lệ ước đoán

`error`: Sai số biên

`level`: khoảng tin cậy

`design`: hệ số thiết kế

Hoặc có thể sử dụng trực tiếp qua câu lệnh 
(Thay đổi các thông số cho phù hợp với mục đích)

Ví dụ

```{js}
zpsampsi, proportion(0.5) error(0.05) level(95) design(1)
```


# 3. Cỡ mẫu ước lượng 1 trung bình

Để sử dụng công thức tính cỡ mẫu cho ước lượng 1 trung bình, vào STATA gõ 

```{js}
db zmsampsi
```
Hộp thoại mở ra, chọn các thông số và nhấn ok. Các thông số bao gồm

`Standard Deviation`: Độ lệch chuẩn

`Marginal Error`: Sai số biên

`Confident interval`: khoảng tin cậy

`Design coeficient`: hệ số thiết kế

Hoặc có thể sử dụng trực tiếp qua câu lệnh 
(Thay đổi các thông số cho phù hợp với mục đích)

Ví dụ

```{js}
zmsampsi, sd(1) error(0.1) level(95) design(1)
```

# 4. Một số chức năng khác 

(Đang update)

| Subcommand      | Description                                                 |
|--------------   |-------------------------------------------------------------|
| `zpsampsi`      | Cỡ mẫu ước lượng 1 tỉ lệ                                    |
| `zmsampsi`      | Cỡ mẫu ước lượng 1 trung bình                               |
| `zesampsi`      | Cỡ mẫu cho nghiên cứu bệnh chứng                            |
| `zrandbnom`     | Đang update                                                 |
| `zrandbin`      | Đang update                                                 |
| `zrand`         | Đang update                                                 |
| `zpps`          | Đang update                                                 |
| `zpblockrand`   | Đang update                                                 |
| `zrandlogn`     | Đang update                                                 |
| `zrandn2`       | Đang update                                                 |
| `zrandnom`      | Đang update                                                 |
| `zrandnorm`     | Đang update                                                 |
| `zrandomize`    | Đang update                                                 |
| `zrobust`       | Đang update                                                 |


