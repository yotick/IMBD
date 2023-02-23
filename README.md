# IMBD
 2023-Pattern Recognition

For reduced scale experiments (simulation), please run *_RS.m, for full scale (real) experiments, please run *_FS.m or *_FS_block.m which is in the block form.

We have created a Share Link – a personalized URL providing 50 days' free access to the article. Anyone clicking on this link before April 13, 2023 will be taken directly to the final version of your article on ScienceDirect, which they are welcome to read or download. No sign up, registration or fees are required.

Share Link:
https://authors.elsevier.com/c/1ge9z77nKkWmE

If you wish to cite this paper, please refer to:

    @article{LU2023109434,
    title = {Intensity mixture and band-adaptive detail fusion for pansharpening},
    volume = {139},
    issn = {0031-3203},
    url = {https://www.sciencedirect.com/science/article/pii/S0031320323001358},
    doi = {https://doi.org/10.1016/j.patcog.2023.109434},
    abstract = {Pansharpening aims to sharpen a low-resolution multispectral ({MS}) image through a high-resolution single-channel panchromatic ({PAN}) image to obtain a high-resolution multi-spectral ({HRMS}) image. However, low correlation between the {PAN} and {MS} images, as well as the inaccurate detail injection for each band of {MS} image are the key problems causing spectral and spatial distortions in pansharpening. To address these issues, a new pansharpening method based on the intensity mixture and band-adaptive detail fusion is proposed. To obtain a mixed-intensity image (T) that has a high correlation with the {MS} image and maintain the gradient information of the {PAN} image, the intensity mixture model is constructed by establishing the intensity and gradient constraints between T and the source images. As it is hard to obtain a proper degradation filter in the model, a filter estimation algorithm is designed by the distribution alignment. To inject the details that match the point spread function of the sensor, a band-adaptive detail fusion algorithm is presented to fuse the details extracted from T with those from the {MS} image for each band. Furthermore, as there are far fewer details in the {MS} image than in T, a detail enhancement algorithm is proposed to enhance the details proportionally. The final {HRMS} image is obtained by injecting the fused details into the upsampled {MS} image. Extensive experiments show that the proposed method can efficiently achieve the best results in fusion quality compared to state-of-the-art methods. The code is availabe at https://github.com/yotick/{IMBD}.},
    pages = {109434},
    journaltitle = {Pattern Recognition},
    author = {Lu, Hangyuan and Yang, Yong and Huang, Shuying and Chen, Xiaolong and Su, Hongfu and Tu, Wei},
    date = {2023},
    keywords = {Band-adaptive detail fusion, Intensity mixture, Pansharpening, Point spread function},
}
