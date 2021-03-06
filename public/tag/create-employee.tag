<create-employee>
    <div class="ui container default-margin-top">
        <h1>
            社員登録
        </h1>
        <form class="ui form error user-form">
            <div class="ui error message" show={errors} id="errorMsgBox">
                <virtual each={values, key in errors}>
                    <div class="header">{key}</div>
                    <virtual each={v in values}>
                        <p>{v}</p>
                    </virtual>
                </virtual>
            </div>
            <div class="two fields">
                <div class="field">
                    <label>社員番号<span class="required-input">*</span></label>
                    <input placeholder="半角数字" type="text" name="employeeNumber">
                </div>
                <div class="field">
                    <label>名前<span class="required-input">*</span></label>
                    <input placeholder="サンプル太郎" type="text" name="name">
                </div>
            </div>
            <div class="two fields">
                <div class="field">
                    <label>カナ<span class="required-input">*</span></label>
                    <input placeholder="サンプルタロウ" type="text" name="kana">
                </div>
                <div class="field">
                    <label>メールアドレス<span class="required-input">*</span></label>
                    <input placeholder="hoge@sample.co.jp" type="text" name="mailAddress">
                </div>
            </div>
            <div class="two fields">
                <div class="field">
                    <label>パスワード<span class="required-input">*</span></label>
                    <input placeholder="password" type="password" name="password">
                </div>
                <div class="field">
                    <label>パスワード（確認）<span class="required-input">*</span></label>
                    <input placeholder="password" type="password" name="passwordConfirm">
                </div>
            </div>
        </form>
        <button class="ui button primary" onclick={create}>登録</button>
    </div>

    <script>
        const self = this
        create()
        {
            const userForm = {}
            $('input[name]').toArray().forEach(function (input) {
                const name = input.name
                userForm[name] = input.value
            })
            $.ajax({
                type: 'POST',
                url: '/create',
                contentType: 'application/json',
                data: JSON.stringify(userForm)
            }).done(function (data) {
                self.globalMessage.add('createdEmployee', data.successes)
                route('/list')
            }).fail(function (xhr) {
                self.dispMessage(self.globalErrorHandler.handle(xhr))
            })
        }

        dispMessage(msg)
        {
            self.errors = msg
            self.update()
            $('#errorMsgBox').transition({
                animation: 'fade in',
                duration: '2s'
            });
        }

    </script>
</create-employee>