#!/bin/bash

# Array of Tenant Key Values
TENANT_KEY_VALUES=(
    205
244
221
262
263
264
265
273
208
266
268
269
270
271
272
212
215
206
216
218
214
210
213
217
207
209
211
226
225
220
227
229
228
231
219
222
224
232
233
234
251
230
237
235
240
238
239
236
241
242
243
223
245
246
248
249
250
252
253
254
247
255
256
257
258
259
260
261
274
275
276
277
278
279
280
281
282
283
267
284
285
286
287
288
289
)

# Counter for container names
counter=1

# Loop through each Tenant Key Value
for TENANT_KEY in "${TENANT_KEY_VALUES[@]}"; do
    echo "Running Docker for Brand Key: $TENANT_KEY"
    docker run -d -e APP_BRANDS_KEY_VALUE_2=$TENANT_KEY -e DB_CHOICE_FROM=db1 --name container${counter} mmtest:importing2
    counter=$((counter+1))
    # The containers are now running in detached mode (-d)
done

echo "All Docker commands have been executed."